## Echo a message when loading the package
.onAttach <- function(...) {
  packageStartupMessage("")
  packageStartupMessage("## The ASW online reference is copyright protected. Accordingly, please cite: ##")
  packageStartupMessage("Frost, Darrel R. <year>. Amphibian Species of the World: an online reference.  Version 6 (DATE OF ACCESS). Electronic Database accessible at http://research.amnh.org/herpetology/amphibia/index.html. American Museum of Natural History, New York, USA.")
  packageStartupMessage("")
}
