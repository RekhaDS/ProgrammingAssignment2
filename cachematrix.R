## makeCacheMatrix creates a list of function to set a matrix/to get a stored matrix/set the value of the 
## inverse and get the stored value of the inverse 
makeCacheMatrix <- function(x = matrix()) {

    ## initialize the variable inverse to NULL
    inverse <- NULL
    
    ## print statement to get the environment 
    print(environment())
    
    evn <- environment()
    
    print(parent.env(evn))
    
    ## set function for setting the value of the matrix argument entered by the user
    
    set <- function(y) {
      x <<- y          ## store the matrix(y) in variable x in the parent environment
      
      inverse <<- NULL ## initialize the variable inverse in the parent environment to NULL, so 
      ## as to reset any previous inverse calculation stored
    }
    
    ## get function for getting the matrix 
    get <- function() {
      x 
    }
    
    ## set the matrix inverse in the parent context
    setsolve <- function(solve) {
      inverse <<- solve ## store the value inverse  in the parent environment
    }
    
    ## get the matrix inverse
    getsolve <- function() {
      inverse ## get the stored inverse from the parent environment
    }
    
    ## get the environment 
    getevn<- function() {environment()}
    
    ## create a list of the functions for easy access to the set of functions created by makeCacheMatrix
    list(set = set, get = get,
         setsolve = setsolve,
         getsolve = getsolve,
         getevn = getevn)
  }
}


## cachesolve takes the argument, that is the list of functions returned by the makeCacheMatrix
cacheSolve <- function(x, ...) {
  
  ## check if the inverse is cached in environment of x , by using the getter getsolve()
  local_inverse <- x$getsolve()
  
  ## if yes then get the cached data
  if(!is.null(local_inverse)) {
    message("getting cached data")
    return(local_inverse)
  }
  
  ## if the above is not true or the else part for if
  ## store the matrix in data
  data <- x$get()
  
  ## store the inverse of the matrix stored in data
  local_inverse <- solve(data, ...)
  
  ## Cache the inverse, by calling the setsolve function from makeCacheMatrix in the environment of x
  x$setsolve(local_inverse)
  
  ## Return a matrix that is the inverse of 'x'
  local_inverse
}
