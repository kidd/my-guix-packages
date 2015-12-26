(use-modules (guix)
             (guix build-system gnu)
             (gnu packages xml)
             ((guix licenses) #:prefix license:))

(package
  (name "xmlstarlet")
  (version "1.6.1")
  (source
   (origin
     (method url-fetch)
     (uri (string-append
           "http://downloads.sourceforge.net/project/xmlstar/xmlstarlet/"
           version
           "/xmlstarlet-"
           version
           ".tar.gz"))
     (sha256
      (base32
       "1jp737nvfcf6wyb54fla868yrr39kcbijijmjpyk4lrpyg23in0m"))))
  (build-system gnu-build-system)
  (inputs
   `(("libxslt" ,libxslt)
     ("libxml2" ,libxml2)))
  (home-page "http://xmlstar.sourceforge.net/")
  (synopsis "XMLStarlet is a set of command line utilities (tools)
which can be used to transform, query, validate, and edit XML
documents and files using simple set of shell commands in similar way
it is done for plain text files using UNIX grep, sed, awk, diff,
patch, join, etc commands.

This set of command line utilities can be used by those who deal
with many XML documents on UNIX shell command prompt as well as
for automated XML processing with shell scripts. " )
  (description #f)
  (license license:bsd-2))
