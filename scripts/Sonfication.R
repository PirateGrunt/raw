
mojo <- "https://aschinchon.wordpress.com/2014/02/11/the-sound-of-mandelbrot-set/"

# Load Libraries
library(ggplot2)
library(reshape)
library(tuneR)

# Create a grid of complex numbers
c.points <- outer(seq(-2.5, 1, by = 0.002),1i*seq(-1.5, 1.5, by = 0.002),'+')
z <- 0
for (k in 1:50) z <- z^2+c.points # Iterations of fractal's formula
c.points <- data.frame(melt(c.points))
colnames(c.points) <- c("r.id", "c.id", "point")
z.points <- data.frame(melt(z))
colnames(z.points) <- c("r.id", "c.id", "z.point")
mandelbrot <- merge(c.points, z.points, by=c("r.id","c.id")) # Mandelbrot Set
# Plotting only finite-module numbers
ggplot(mandelbrot[is.finite(-abs(mandelbrot$z.point)), ], aes(Re(point), Im(point), fill=exp(-abs(z.point))))+
  geom_tile()+theme(legend.position="none", axis.title.x = element_blank(), axis.title.y = element_blank())

#####################################################################################
# Function to translate numbers (complex modules) into sounds between 2 frequencies
#   the higher the module is, the lower the frequencie is
#   modules greater than 2 all have same frequencie equal to low.freq
#   module equal to 0 have high.freq
#####################################################################################
Module2Sound <- function (x, low.freq, high.freq)
{
  if(x>2 | is.nan(x)) {low.freq} else {x*(low.freq-high.freq)/2+high.freq}
} 

#####################################################################################
# Function to create wave. Parameters:
#    complex     : complex number to test
#    number.notes: number of notes to create (notes = iterations)
#    tot.duration.secs: Duration of the wave in seconds
#####################################################################################
CreateSound <- function(complex, number.notes, tot.duration.secs)
{
  dur <- tot.duration.secs/number.notes
  sep1 <- paste(", bit = 32, duration= ",dur, ", xunit = 'time'),sine(")
  sep2 <- paste(", bit = 32, duration =",dur,",  xunit = 'time'))")
  v.sounds <- c()
  z <- 0
  for (k in 1:number.notes) 
  {
    z <- z^2+complex
    v.sounds <- c(v.sounds, abs(z))
  }
  v.freqs <- as.vector(apply(data.frame(v.sounds), 1, FUN=Module2Sound, low.freq=280, high.freq=1046))
  eval(parse(text=paste("bind(sine(", paste(as.vector(v.freqs), collapse = sep1), sep2)))
}
sound1 <- CreateSound(-3/4+0.01i     , 400 , 10) # Slow Divergence
sound2 <- CreateSound(-0.1528+1.0397i, 400  , 10) # Feigenbaum Point
sound3 <- CreateSound(-1+0i          , 400  , 10) # Ambulance Siren

writeWave(sound1, 'SlowDivergence.wav')
writeWave(sound2, 'FeigenbaumPoint.wav')
writeWave(sound3, 'AmbulanceSiren.wav')
