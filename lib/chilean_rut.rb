##
#All functions are just defined statically in this module
class RUT

  ##
  #Returns boolean wether the given string is a valid Digito Verificador character or not
  def self.valid_dv(dv)
    ['0','1','2','3','4','5','6','7','8','9','k','K'].include?(dv)
  end

  ##
  #Every R.U.T. has a single valid Digito Verificador which is calculated based on its digits
  #
  #Given a R.U.T. this function returns its Digito Verificador as a string
  def self.get_dv(rut)
    suma=0
    mul=2
    rut.reverse.split("").each do |c|
      suma=suma+c.to_i*mul
      if mul==7
        mul=2
      else
        mul+=1
      end
    end
    res=suma%11
    if res==1
      return 'k'
    elsif res==0
      return '0'
    else
      return 11-res
    end
  end

  ##
  #Given a R.U.T. including its Digito Verificador (whatever the format, i.e. with or without points & hyphens)
  #
  #This function returns boolean wether the Digito Verificador matches the R.U.T. or not
  def self.validate_dv(crut)
    return false if crut.size < 2
    if crut.size > 2
      rut=crut[0...crut.size-1]
    else
      rut=crut[0]
    end
    dv=crut[crut.size-1]
    return false if !valid_dv(dv)
    if rut.nil? || dv.nil?
      return 0 #TODO ?
    end
    dvr=get_dv(rut)
    dvr.to_s==dv.downcase
  end

  ##
  #Strips a R.U.T. format (points & hyphens)
  def self.remove_format(rut)
    rut=rut.delete "."
    rut=rut.delete "-"
  end

  #Strips a R.U.T. format (only points)
  def self.remove_points(rut)
    rut=rut.delete "."
  end

  #Strips a R.U.T. format (only hyphens)
  def self.remove_hyphens(rut)
    rut=rut.delete "-"
  end

  ##
  #Given a R.U.T. (whatever the format, i.e. with or without points & hyphens) this method returns boolean wether it is valid or not
  def self.validate(texto)
    texto=self.remove_format(texto)
    return false if texto.size < 2
    texto.split("").each do |c|
      return false if !valid_dv(c)
    end
    invertido=texto.reverse
    dtexto=invertido[0]+"-"
    cnt=0
    i=1
    j=2
    for x in 1...texto.size do
      if cnt==3
        dtexto=dtexto+"."
        j+=1
        dtexto=dtexto+invertido[x]
        cnt=1
      else
        dtexto=dtexto+invertido[x]
        cnt+=1
      end
      i+=1
      j+=1
    end
    invertido=""
    i=dtexto.size-1
    j=0
    (0..i).to_a.reverse.each do |y|
      invertido=invertido+dtexto[y]
      j+=1
    end
    return validate_dv(texto)
  end

  ##
  #This method will give a raw R.U.T. string its proper format adding the right points & hyphens
  def self.format(raw_rut)
    rut = raw_rut.to_s.delete '.-'
    if rut.nil? || rut.empty?
      return rut
    end
    rut_end = rut[rut.length - 1, rut.length]
    rut_init_temp = rut[0, rut.length - 1]
    rut_init = ''
    while rut_init_temp.length > 3 do
      rut_init = '.' + rut_init_temp[rut_init_temp.length - 3, rut_init_temp.length] + rut_init
      rut_init_temp = rut_init_temp[0, rut_init_temp.length - 3]
    end
    rut = rut_init_temp+rut_init+'-'+rut_end
    return rut.upcase
  end

  ##
  #This method will give a raw R.U.T. string this method returns boolean wether it no is valid or a hash if string is a valid rut
  def self.get_rut_and_dv(rut)
    unless self.validate(rut)
      return false
    end

    rut = self.format(rut).split("-")

    out = {
      :rut => rut.first.delete("."),
      :dv => rut.last
    }
  end

end
