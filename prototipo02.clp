  
  ; Proyecto Final , Alumno : Pablo Courault
  ; Prototipo para resolver el caso real planteado
  ; se encuentra en fase de desarrollo, no esta terminado


  ; lo que este recuadrado con asteriscos son situaciones todavia no resueltas
  ; o soluciones no exploradas
  
    
  ; definicion de plantillas
  ; en un principio los datos que se van a manejar son suficientes para la correcta
  ; seleccion e identificacion de los productos involucrados en el proceso


  
  (deftemplate medicamento
     (slot nombre)
     (slot fabricante)
     (slot calidad)
     (slot rentabilidad)
     (slot demanda)
     (slot convcom))
     
     
  ; la utilizo para elegir  de un grupo de medicamentos
  ; por ahora  no fue necesario, pero la indico como una idea
  ; de como ir "guardando" resultados parciales de la ejecucion del programa
     
     
  ;(deftemplate preseleccion-medicamento
  ;  (slot nombre-pre)
  ;  (slot fabricante)
  ;  (slot calidad-pre)
  ;  (slot rentabilidad-pre)
  ;  (slot demanda-pre)
  ;  (slot convcom-pre))
     
  
  ; hechos iniciales    
  
  ; ACLARACION IMPORTANTE
  
  ; el sistema intenta seleccionar el producto adecuado dentro de una coleccion
  ; de productos disponibles, y de acuerdo a los intereses de la empresa que lo
  ; utiliza, en el caso de haber un producto disponible que 
  ; supere al resto, saldria siempre el mismo, por lo que las pruebas se van 
  ; a ir haciendo inicialmente sobre distintos conjuntos de medicamentos disponibles
  ; para ver como se comporta el prototipo ante esas distintas situaciones
  

  ; los medicamentos expuestos como hechos, son medicamentos existentes en el mercado
  ; el criterio de clasificacion de los mismos es acorde a la perspectiva del experto
  ; y los intereses de la empresa y no son en si una clasificacion aplicable en general.


 
  (deffacts medicamentos
    
    ; el siguiente es un medicamento de fantasia utilizado para pruebas del sistema
       
     (medicamento (nombre "Ivermectina de Fantasia")
                  (fabricante Fantasia)
                  (calidad excelente)
                  (rentabilidad excelente)
                  (demanda buena)
                  (convcom buena))
  
     (medicamento (nombre Ivomec)
                  (fabricante Merck)
                  (calidad excelente)
                  (rentabilidad mala)
                  (demanda buena)
                  (convcom regular))
  
     (medicamento (nombre Ivergen)
                  (fabricante Biogenesis)
                  (calidad excelente)
                  (rentabilidad excelente)
                  (demanda buena)
                  (convcom excelente))
                  
     (medicamento (nombre Bovicine)
                  (fabricante Richmond)
                  (calidad buena)
                  (rentabilidad buena)
                  (demanda regular)
                  (convcom regular))
                  
     (medicamento (nombre Vermectin)
                  (fabricante Over)
                  (calidad buena)
                  (rentabilidad buena)
                  (demanda buena)
                  (convcom buena))
                  
     (medicamento (nombre Iverplus)
                  (fabricante Aviar)
                  (calidad regular)
                  (rentabilidad buena)
                  (demanda mala)
                  (convcom regular))
                  
     (medicamento (nombre Baymec)
                  (fabricante Bayer)
                  (calidad "muy buena")
                  (rentabilidad regular)
                  (demanda regular)
                  (convcom mala))
                  
     (medicamento (nombre Meltra)
                  (fabricante Brower)
                  (calidad regular)
                  (rentabilidad buena)
                  (demanda regular)
                  (convcom mala))
                  
     (medicamento (nombre Necaverm)
                  (fabricante Rosenbusch)
                  (calidad buena)
                  (rentabilidad buena)
                  (demanda excelente)
                  (convcom buena))
                  
     (medicamento (nombre Inandex)
                  (fabricante Estrella)
                  (calidad "muy buena")
                  (rentabilidad "muy buena")
                  (demanda mala)
                  (convcom regular))
                       
                  (comenzar-seleccion))
                  
 
  ; Escala de valores utilizada
  
  ; En un principio trabaje con una escala numerica, pero estoy intentando
  ; aprovechar el poder de comparacion de patrones de clips, por ahora esta
  ; escala no esta implementada 
         
  ; excelente = 5
  ; muy bueno = 4
  ; bueno = 3
  ; regular = 2
  ; mala = 1
   
  
  ; reglas
  
  
  ; el caso siguiente es algo que probablemente nunca suceda
  
  (defrule medicamento-ideal
      
     (medicamento (nombre ?nombre)
                  (fabricante ?fabricante)
                  (calidad excelente)
                  (rentabilidad excelente)
                  (demanda excelente)
                  (convcom excelente))  
           ?f0 <- (comenzar-seleccion)       

     => 
     
     (retract ?f0)
   
     (printout t crlf " El producto aconsejado es : " ?nombre ". Fabricante : " ?fabricante crlf crlf)) 
     
     
  ; caso de productos que tengan una excelente calidad
  ; primer caso de productos con calidad exelente y rentabilidad iguales
  
  ; ***************************************************************************
  ; * otro camino seria ver que tengan igual calidad, osea preguntar en forma *
  ; * mas amplia                                                              *
  ; ***************************************************************************
  
  (defrule medicamentos-01
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom excelente))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda2)
                  (convcom ~excelente))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
  
  ; segundo caso de productos que tengan una excelente calidad y rentabilidad iguales
  
  (defrule medicamentos-02
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom "muy buena"))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom buena | regular))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
  ; tercer caso de productos que tengan una excelente calidad y rentabilidad iguales
  
  (defrule medicamentos-03
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom buena))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom regular | mala))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  ; caso de productos que tengan una muy buena calidad y rentabilidad iguales
  
  (defrule medicamentos-04
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom "muy buena"))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom buena | regular))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
     
  ; caso de productos que tengan una muy buena calidad y rentabilidad iguales
  
  (defrule medicamentos-05
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom buena))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom  regular))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
  ; caso de productos que tengan una  buena calidad y rentabilidad iguales
  
  (defrule medicamentos-06
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom "muy buena"))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom  buena | regular))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  ; caso de productos que tengan una calidad regular y rentabilidad iguales y demanda iguales
  ; si la rentabilidad no es muy ventajosa, no es aconsejable vender productos de mala calidad
  ; que ademas no es el caso de la realidad, pero se esta contemplando la situacion
  
  (defrule medicamentos-07
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad regular)
                  (rentabilidad ?rentabilidad1 & ~buena & ~mala & ~regular)
                  (demanda ?demanda1)
                  (convcom "muy buena"))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad regular)
                  (rentabilidad ?rentabilidad1 & ~buena & ~mala & ~regular)
                  (demanda ?demanda2)
                  (convcom  buena | regular))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  ; caso de productos que tengan una calidad regular y rentabilidad iguales y conveniencia comercial iguales
  ; si la rentabilidad no es muy ventajosa, no es aconsejable vender productos de mala calidad
  ; si no tienen buena demanda tampoco conviene trabajar sobre ellos
  ; que ademas no es el caso de la realidad, pero se esta contemplando la situacion
  
  (defrule medicamentos-08
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad regular)
                  (rentabilidad ?rentabilidad1 & ~buena & ~mala & ~regular)
                  (demanda excelente)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad regular)
                  (rentabilidad ?rentabilidad1 & ~buena & ~mala & ~regular)
                  (demanda "muy buena")
                  (convcom  ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  
  ; caso de productos que tengan una excelente calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-09
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda excelente)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena" | buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  
  ; caso de productos que tengan una excelente calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-10
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena")
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  ; caso de productos que tengan una excelente calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-11
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda regular | mala)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  
  ; caso de productos que tengan una muy buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-12
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda excelente)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena" | buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  
  ; caso de productos que tengan una muy buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-13
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena")
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  ; caso de productos que tengan una muy buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-14
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda regular | mala)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
         
  
  ; caso de productos que tengan una buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-15
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda excelente)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena" | buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  
  ; caso de productos que tengan una buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-16
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda "muy buena")
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena | regular)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
     
  ; caso de productos que tengan una buena calidad, rentabilidades iguales
  ; conveniencias comerciales iguales
  
  (defrule medicamentos-17
  
    
     (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda buena)
                  (convcom ?convcom1))
                  
     (medicamento (nombre ?nombre2 & ~?nombre1)
                  (fabricante ?fabricante2)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1 & ~mala & ~regular)
                  (demanda regular | mala)
                  (convcom ?convcom1))
           ?f0 <- (comenzar-seleccion)       
     
     =>
     
     (retract ?f0)  
       
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
     
  
  ; caso de un producto que tenga una excelente calidad
  ; y una rentabilidad igual a otros de inferior calidad
  
  (defrule medicamentos-18

     
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena | regular | mala)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          

     =>
     
     (retract ?f0)
   
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))  
     
     
  (defrule medicamentos-19
  
  ; caso de un producto que tenga una muy buena calidad
  ; y una rentabilidad igual a otros de inferior calidad

     
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad  buena | regular | mala)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          

     =>
     
     (retract ?f0)
   
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
     
  (defrule medicamentos-20
  
  ; caso de un producto que tenga una buena calidad
  ; y una rentabilidad igual a otros de inferior calidad

     
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad buena)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad  regular | mala)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          

     =>
     
     (retract ?f0)
      
     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     

  (defrule medicamentos-21
  
  ; caso de un producto que tenga una calidad regular
  ; y una rentabilidad igual a otros de inferior calidad
     
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad regular)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad mala)
                  (rentabilidad ?rentabilidad1)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          

     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
       
  ; caso de un producto con una excelente calidad y una rentabilidad mejor a otros de menor calidad
  
  (defrule medicamentos-22
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad excelente)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena | regular | mala)
                  (rentabilidad "muy buena" | buena | regular | mala)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
   
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
  
     
  ; caso de un producto que tenga una excelente calidad
  ; y una rentabilidad muy buena con respecto a otros de inferior calidad y rentabilidad
  
  (defrule medicamentos-23
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad "muy buena")
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena)
                  (rentabilidad  buena)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
     
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
     
  ; caso de un producto que tenga una excelente calidad
  ; y una rentabilidad buena con respecto a otros de inferior calidad y rentabilidad
  
  (defrule medicamentos-24
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad buena)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena)
                  (rentabilidad regular | mala)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
  
     =>
     
    (retract ?f0)
    
    (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
   
  ; caso de un producto que tenga una excelente calidad
  ; y una rentabilidad regular con respecto a otros de inferior calidad y rentabilidad   
    
  (defrule medicamentos-25
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad excelente)
                  (rentabilidad regular)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena)
                  (rentabilidad mala)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
        
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
     
   ; caso de un producto con una muy buena calidad y una rentabilidad mejor a otros de menor calidad
  
  (defrule medicamentos-26
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad excelente)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena)
                  (rentabilidad "muy buena" | buena)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
   
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
  
     
  ; caso de un producto que tenga una muy buena calidad
  ; y una rentabilidad muy buena con respecto a otros de inferior calidad y rentabilidad
  
  (defrule medicamentos-27
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad "muy buena")
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena)
                  (rentabilidad  buena | regular)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
     
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
     
  ; caso de un producto que tenga una muy buena calidad
  ; y una rentabilidad buena con respecto a otros de inferior calidad y rentabilidad
  
  (defrule medicamentos-28
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad buena)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena )
                  (rentabilidad regular | mala)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
  
     =>
     
    (retract ?f0)
  
    (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     
   
  ; caso de un producto que tenga una muy buena calidad
  ; y una rentabilidad regular con respecto a otros de inferior calidad y rentabilidad   
     
  (defrule medicamentos-29
  
    (medicamento (nombre ?nombre1)
                  (fabricante ?fabricante1)
                  (calidad "muy buena")
                  (rentabilidad regular)
                  (demanda ?demanda1)
                  (convcom ?convcom1))
  
    
     (medicamento (nombre ?nombre2)
                  (fabricante ?fabricante2)
                  (calidad "muy buena" | buena )
                  (rentabilidad mala)
                  (demanda ?demanda2)
                  (convcom ?convcom2))
                  
           ?f0 <- (comenzar-seleccion)          
        
     =>
     
     (retract ?f0)

     (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf)) 
     

     
     
     
  ; esquema general de comparacion
  ; es para desarrollar el proyecto no se usa en el codigo final
  
  ; (defrule medicamentos-esquema-general
  
  ; (medicamento (nombre ?nombre1)
  ;              (fabricante ?fabricante1)
  ;              (calidad excelente | "muy buena" | buena | regular | mala)
  ;              (rentabilidad excelente | "muy buena" | buena | regular | mala)
  ;              (demanda excelente | "muy buena" | buena | regular | mala)
  ;              (convcom excelente | "muy buena" | buena | regular | mala))
  
    
  ; (medicamento (nombre ?nombre2)
  ;              (fabricante ?fabricante2)
  ;              (calidad excelente | "muy buena" | buena | regular | mala)
  ;              (rentabilidad excelente | "muy buena" | buena | regular | mala)
  ;              (demanda excelente | "muy buena" | buena | regular | mala)
  ;              (convcom excelente | "muy buena" | buena | regular | mala))
                  
  ;              ?f0 <- (comenzar-seleccion)          
   
  ;  =>
     
  ;  (retract ?f0)

  ; (printout t crlf " El producto aconsejado es : " ?nombre1 ". Fabricante : " ?fabricante1 crlf crlf))
            

