## ------------------------------------------------------------------------
mySquare<-function(x) x^2

class(mySquare)

mySquare(3)

mySquare(1:6)

attributes(mySquare)

mySquare

formals(mySquare)

body(mySquare)

## ------------------------------------------------------------------------

myQuad<-function(a,b,c){
  D<-b^2-4*a*c
  if (D<0) {print("No Real Roots")} else
      {if (D==0) {x<- (-b/(2*a))} else
      {
        x1<- (-b+sqrt(D))/(2*a)
        x2<- (-b-sqrt(D))/(2*a)
        x<-c(x1,x2)}
        return(x)}
}


