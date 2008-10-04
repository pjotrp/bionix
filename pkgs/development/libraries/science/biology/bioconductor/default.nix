{stdenv, fetchurl, rLang ? null}:


let

  /* Function to compile Bioconductor packages */

  buildBioConductor =
    { pname, pver, src, postInstall ? ""}:

    stdenv.mkDerivation {
      name = "r-bioconductor-${pname}-${pver}";

      inherit src;

      buildInputs = [rLang];

      # dontAddPrefix = true;

      # preBuild = "makeFlagsArray=(dictdir=$out/lib/aspell datadir=$out/lib/aspell)";

      inherit postInstall;
      # installPhase = ''
      #   R CMD INSTALL ${affyioSrc}
      # '';
      installPhase = ''
        tar xvzf ${src}
        R CMD INSTALL ${pname} $out
        R CMD INSTALL ${affyioSrc}
      '';

      meta = {
        description = "Bioconductor package for ${pname}";
        homepage = http://www.bioconductor.org/;
      };
    };

in {

   affyio = buildBioConductor {
     pname = "affyio";
     pver  = "1.8.1";
     src = fetchurl {
       url = http://www.bioconductor.org/packages/release/bioc/src/contrib/affyio_1.8.1.tar.gz;
       sha256 = "136nkpq870vrwf9z5gq32xjzrp8bjfbk9pn8fki2a5w2lr0qc8nh";
     };
   };

    
}
