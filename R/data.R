#' @name Hurricane
#' 
#' @title Hurricane data
#' 
#' @description
#' 
#' Listing of the position of and windspeed of hurricanes.
#' 
#' Data is taken from the National Hurricane Center, a division of the
#' National Oceanic and Atmospheric Association.
#' 
#' @format A data frame with 7 variables:
#'    \code{Year}, \code{Number}, \code{ISO_Time}
#'    , \code{Latitude}, \code{Longitude}, \code{Wind}
#' 
"Hurricane"

#' @name StateExperience
#' 
#' @title State data
#' 
#' @description
#' 
#' Random illustrative data
#' 
#' @format A data frame with 7 variables:
#'    \code{Fullname}, \code{PolicyYear}, \code{Postal}
#'    , \code{NumPolicies}, \code{PolicyGrowth}, \code{Lambda}
#'    , \code{BasePolicies}, \code{NumClaims}, \code{Region}
#' 
"StateExperience"

#' @name RegionExperience
#' 
#' @title Region data
#' 
#' @description
#' 
#' Consolidation of state data into various regions
#' 
#' @format A data frame with four variables:
#'    \code{Region}, \code{PolicyYear}
#'    , \code{NumPolicies}, \code{NumClaims}
"RegionExperience"

#' @name NFL
#' 
#' @title NFL game data
#' 
#' @description
#' 
#' Results of over 13,000 NFL games
#' 
#' @format Data frame with 25 variables
#'    \code{Week}, \code{Day}, \code{Date}, \code{Outcome}
#'    , \code{OT}, \code{Record}, \code{Home}, \code{Opponent}
#'    , \code{ThisTeamScore}, \code{OpponentScore}
#'    , \code{ThisTeam1D}, \code{ThisTeamTotalYards}
#'    , \code{ThisTeamPassYards}, \code{ThisTeamRushYards}
#'    , \code{ThisTeamTO}, \code{Opponent1D}
#'    , \code{OpponentTotalYards}, \code{OpponentPassYards}
#'    , \code{OpponentRushYards}, \code{OpponentTO}
#'    , \code{GameDate}, \code{TODiff}
#'    , \code{Win}, \code{ThisTeam}, \code{ScoreDifference}  
#' 
"NFL"