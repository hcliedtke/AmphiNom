## Echo a message when loading the package
.onAttach <- function(...) {
  packageStartupMessage("")
  packageStartupMessage("!!The ASW online reference is copyright protected. Any use of its product via AmphiNom requires that copyright and terms of use are adhered to. See: http://research.amnh.org/vz/herpetology/amphibia/Copyright-and-terms-of-use!!")
  packageStartupMessage("")
}
