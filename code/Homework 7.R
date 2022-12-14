#Generate clustered spatial point process

library(spatstat)

## Generate Date ##==========================================
#define variables
#variables that control the size and strength of clusters
val.at.center=1
effect.range=10 
background=0.001

#variables that control the number of points and spatial dimensions
Pointnum=100
Xmin=-50
Xmax=50
Ymin=-50
Ymax=50

#define the center locations and set up the distance vector
centers=matrix(data=c(-25,-25,25,25,-25,25,-25,25),nrow=4,ncol=2)
dist=matrix(nrow=4,ncol=1)

# can also change centers to influence the ripley's K plot


#define outputs
output.X=matrix(nrow = Pointnum, ncol = 1)
output.Y=matrix(nrow = Pointnum, ncol = 1)

#precalcs - calculate the slope of the clustering effect
slope=(val.at.center-background)/effect.range

#set a counter
outcounter=0

#main for loop
for (i in 1:100000){
  #generate a random candidate point
  x.candidate=runif(1, min=Xmin, max=Xmax)
  y.candidate=runif(1, min=Ymin, max=Ymax)
  
  #calculate the distance between the candidate point and the nearest cluster center
  for (j in 1:4){
  dist[j]=sqrt((x.candidate-centers[j,1])^2+(y.candidate-centers[j,2])^2)
  }
  min.dist=min(dist)
  
  #calculate the probability of retaining the candidate point
  if(min.dist<effect.range){
    prob=val.at.center-slope*min.dist
  }
  else
    prob=background
    
  #roll the dice to see if you keep the candidate point
  testval=runif(1,min=0,max=1)  
  if (testval<prob){
    outcounter=outcounter+1
    keep=1
    output.X[outcounter]=x.candidate
    output.Y[outcounter]=y.candidate
  }

  #if you've reached your target number of points, break from the for loop
  if(outcounter==Pointnum){
    break
  }
}

#plot the points and the cluster centers
plot(output.X,output.Y)
points(centers,type="p", col="red", pch=21, bg="red")

#create a point pattern object for analysis using the spatstat library
output_ppp = ppp(output.X, output.Y, c(Xmin,Xmax), c(Ymin,Ymax))

##### Question 1.3 ##### Randomly generate data #=============================

output.X.rand = runif(100, Xmin, Xmax)
output.Y.rand = runif(100, Ymin, Ymax)

plot(output.X.rand,output.Y.rand)

##### Question 2 ##### #==========================================

# create a ppp object for the random data

pppRand  = ppp(output.X.rand, output.Y.rand, c(Xmin,Xmax), c(Ymin,Ymax))

quadrat.test(output_ppp)
quadrat.test(pppRand)

# Question 3 #### #========================================
# calculate and plot Ripley's K


randEnv = envelope(pppRand)

plot(Kest(output_ppp))
plot(Kest(pppRand))

# Question 4 ####=============================================

#### Running with center at 0, 0

centers=matrix(data=c(0,0,0,0,0,0,0,0),nrow=4,ncol=2)


dist=matrix(nrow=4,ncol=1)

centers=matrix(data=c(0,0,0,0,0,0,0,0),nrow=4,ncol=2)

# can also change centers to influence the ripley's K plot


#define outputs
output.X=matrix(nrow = Pointnum, ncol = 1)
output.Y=matrix(nrow = Pointnum, ncol = 1)

#precalcs - calculate the slope of the clustering effect
slope=(val.at.center-background)/effect.range

#set a counter
outcounter=0

#main for loop
for (i in 1:100000){
  #generate a random candidate point
  x.candidate=runif(1, min=Xmin, max=Xmax)
  y.candidate=runif(1, min=Ymin, max=Ymax)
  
  #calculate the distance between the candidate point and the nearest cluster center
  for (j in 1:4){
    dist[j]=sqrt((x.candidate-centers[j,1])^2+(y.candidate-centers[j,2])^2)
  }
  min.dist=min(dist)
  
  #calculate the probability of retaining the candidate point
  if(min.dist<effect.range){
    prob=val.at.center-slope*min.dist
  }
  else
    prob=background
  
  #roll the dice to see if you keep the candidate point
  testval=runif(1,min=0,max=1)  
  if (testval<prob){
    outcounter=outcounter+1
    keep=1
    output.X[outcounter]=x.candidate
    output.Y[outcounter]=y.candidate
  }
  
  #if you've reached your target number of points, break from the for loop
  if(outcounter==Pointnum){
    break
  }
}

#plot the points and the cluster centers
plot(output.X,output.Y)
points(centers,type="p", col="red", pch=21, bg="red")

#create a point pattern object for analysis using the spatstat library
output_pppCenter = ppp(output.X, output.Y, c(Xmin,Xmax), c(Ymin,Ymax))

# calculate and plot Ripley's K
plot(Kest(output_pppCenter))


