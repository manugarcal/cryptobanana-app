class HomeController < ApplicationController
  
  def index

    time = Time.new.strftime("%s%L").to_i #definicion de el tiempo actual en formato milisegundos unix datastamp convertido en entero
    day = 86400000 #24 hrs a milisegundos - entero
    last24 = time - day # operacion para optener las ultimas 24 hrs en unix datastamp
    
    #endpoints por mercado
    urlBTC_CLP = "https://www.buda.com/api/v2/markets/BTC-CLP"
    urlBTC_COP = "https://www.buda.com/api/v2/markets/BTC-COP"
    urlETH_CLP = "https://www.buda.com/api/v2/markets/ETH-CLP"
    urlETH_BTC = "https://www.buda.com/api/v2/markets/ETH-BTC"
    urlBTC_PEN = "https://www.buda.com/api/v2/markets/BTC-PEN"
    urlETH_PEN = "https://www.buda.com/api/v2/markets/ETH-PEN"
    urlETH_COP = "https://www.buda.com/api/v2/markets/ETH-COP"
    urlBCH_BTC = "https://www.buda.com/api/v2/markets/BCH-BTC"
    urlBCH_CLP = "https://www.buda.com/api/v2/markets/BCH-CLP"
    urlBCH_COP = "https://www.buda.com/api/v2/markets/BCH-COP"
    urlBCH_PEN = "https://www.buda.com/api/v2/markets/BCH-PEN"
    urlBTC_ARS = "https://www.buda.com/api/v2/markets/BTC-ARS"
    urlETH_ARS = "https://www.buda.com/api/v2/markets/ETH-ARS"
    urlBCH_ARS = "https://www.buda.com/api/v2/markets/BCH-ARS"
    urlLTC_BTC = "https://www.buda.com/api/v2/markets/LTC-BTC"
    urlLTC_CLP = "https://www.buda.com/api/v2/markets/LTC-CLP"
    urlLTC_COP = "https://www.buda.com/api/v2/markets/LTC-COP"
    urlLTC_PEN = "https://www.buda.com/api/v2/markets/LTC-PEN"
    urlLTC_ARS = "https://www.buda.com/api/v2/markets/LTC-ARS"


    #metodo get para obtener datos desde los endpoints: recibe como parametro el endpoint especifico
    def getData(url)
      data = RestClient.get url 
      result = JSON.parse data.to_str
      return result
    end

   
    #metodo para obtener las transacciones de las ultimas 24 hrs: recive como parametro el endpoint especifico 
    def volume(result)
      return result['trades']['entries'].collect do |data|
          volume = data[1].to_f
      end
    end

    #metodo para obtener el último precio desde la endpoint especifica de cada mercado desde el endpoint
    def getPrice(result)
      return result['ticker']['last_price'][0].tap do |data|
        price = data.to_f
      end
    end
    
    #variable para los endpoints de cada mercado obteniendo las transacciones de las últimas 24hrs
    trades = "/trades?timestamp=#{last24}"
    
    #variables llamables en html donde se usan los metodos volume y getdata y se aplica el metodo .max para cada valor maximo en cada mercado
    @maxValueBTC_CLP = volume(getData(urlBTC_CLP+=trades)).max
    @maxValueBTC_COP = volume(getData(urlBTC_COP+=trades)).max
    @maxValueETH_CLP = volume(getData(urlETH_CLP+=trades)).max
    @maxValueETH_BTC = volume(getData(urlETH_BTC+=trades)).max
    @maxValueBTC_PEN = volume(getData(urlBTC_PEN+=trades)).max
    @maxValueETH_PEN = volume(getData(urlETH_PEN+=trades)).max
    @maxValueETH_COP = volume(getData(urlETH_COP+=trades)).max
    @maxValueBCH_BTC = volume(getData(urlBCH_BTC+=trades)).max
    @maxValueBCH_CLP = volume(getData(urlBCH_CLP+=trades)).max
    @maxValueBCH_COP = volume(getData(urlBCH_COP+=trades)).max
    @maxValueBCH_PEN = volume(getData(urlBCH_PEN+=trades)).max
    @maxValueBTC_ARS = volume(getData(urlBTC_ARS+=trades)).max
    @maxValueETH_ARS = volume(getData(urlETH_ARS+=trades)).max
    @maxValueBCH_ARS = volume(getData(urlBCH_ARS+=trades)).max
    @maxValueLTC_BTC = volume(getData(urlLTC_BTC+=trades)).max
    @maxValueLTC_CLP = volume(getData(urlLTC_CLP+=trades)).max
    @maxValueLTC_COP = volume(getData(urlLTC_COP+=trades)).max
    @maxValueLTC_PEN = volume(getData(urlLTC_PEN+=trades)).max
    @maxValueLTC_ARS = volume(getData(urlLTC_ARS+=trades)).max



    #variables llamables en html donde se usan los metodos getPrice y getData para obtener el precio actualizado de cada mercado
    
    @priceBTC_CLP = getPrice(getData("https://www.buda.com/api/v2/markets/BTC-CLP/ticker")).to_f
    @priceBTC_COP = getPrice(getData("https://www.buda.com/api/v2/markets/BTC-COP/ticker")).to_f
    @priceETH_CLP = getPrice(getData("https://www.buda.com/api/v2/markets/ETH-CLP/ticker")).to_f
    @priceETH_BTC = getPrice(getData("https://www.buda.com/api/v2/markets/ETH-BTC/ticker")).to_f
    @priceBTC_PEN = getPrice(getData("https://www.buda.com/api/v2/markets/BTC-PEN/ticker")).to_f
    @priceETH_PEN = getPrice(getData("https://www.buda.com/api/v2/markets/ETH-PEN/ticker")).to_f
    @priceETH_COP = getPrice(getData("https://www.buda.com/api/v2/markets/ETH-COP/ticker")).to_f
    @priceBCH_BTC = getPrice(getData("https://www.buda.com/api/v2/markets/BCH-BTC/ticker")).to_f
    @priceBCH_CLP = getPrice(getData("https://www.buda.com/api/v2/markets/BCH-CLP/ticker")).to_f
    @priceBCH_COP = getPrice(getData("https://www.buda.com/api/v2/markets/BCH-COP/ticker")).to_f
    @priceBCH_PEN = getPrice(getData("https://www.buda.com/api/v2/markets/BCH-PEN/ticker")).to_f
    @priceBTC_ARS = getPrice(getData("https://www.buda.com/api/v2/markets/BTC-ARS/ticker")).to_f
    @priceETH_ARS = getPrice(getData("https://www.buda.com/api/v2/markets/ETH-ARS/ticker")).to_f
    @priceBCH_ARS = getPrice(getData("https://www.buda.com/api/v2/markets/BCH-ARS/ticker")).to_f
    @priceLTC_BTC = getPrice(getData("https://www.buda.com/api/v2/markets/LTC-BTC/ticker")).to_f
    @priceLTC_CLP = getPrice(getData("https://www.buda.com/api/v2/markets/LTC-CLP/ticker")).to_f
    @priceLTC_COP = getPrice(getData("https://www.buda.com/api/v2/markets/LTC-COP/ticker")).to_f
    @priceLTC_PEN = getPrice(getData("https://www.buda.com/api/v2/markets/LTC-PEN/ticker")).to_f
    @priceLTC_ARS = getPrice(getData("https://www.buda.com/api/v2/markets/LTC-ARS/ticker")).to_f


   
    

   

  
  end
  
end
