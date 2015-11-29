;; converted from /home/rgrau/Downloads/nixpkgs/pkgs/servers/http/openresty/default.nix:9
;; <civodul> rgrau: using the 'inputs' keyword passed to the phase's procedure  [20:26]
;; <civodul> search for "(assoc-ref inputs" in gnu/packages/*.scm

;; Download from: https://openresty.org/download/ngx_openresty-1.9.3.2.tar.gz
(use-modules (guix)
             (guix build-system gnu)
             (gnu packages perl)
             (gnu packages gcc)
             (gnu packages compression)
             (gnu packages xml)
             (gnu packages lua)
             (gnu packages tls)
             (gnu packages pcre)
             ((guix licenses) #:prefix license:))

(package
  (name "openresty")
  (version "1.9.3.2")
  (source
   (origin
     (method url-fetch)
     (uri (string-append
           "http://openresty.org/download/ngx_openresty-"
           version
           ".tar.gz"))
     (sha256
      (base32
       "11p0042sksmj8my00wrs82k8kh5y2mj73nv9v8nd4cjsdqbg02lz"))))
  (build-system gnu-build-system)
  (inputs
   `(("perl" ,perl)
     ("libxslt" ,libxslt)
     ("libxml2" ,libxml2)
     ("pcre" ,pcre)
     ("gcc" ,gcc)
     ("zlib" ,zlib)
     ("openssl" ,openssl)))
  (native-inputs
   `(("perl" ,perl)
     ("gcc" ,gcc)
     ))
  (arguments
   `(#:tests? #f
     #:phases
     (modify-phases %standard-phases
       (replace 'configure
                (lambda* (#:key inputs outputs #:allow-other-keys)
                  (substitute* "configure"
                    (("ldconfig") "true")
                    )
                  (substitute* "bundle/nginx-1.9.3/auto/feature"
                    (("/bin/sh") (which "bash")))
                  (for-each delete-file
                            '("bundle/redis2-nginx-module-0.12/misc/serv.erl"))
                  (setenv "CC" "gcc")
                  (system* "perl" "./configure" "--with-cc=gcc"
                           (string-append "--prefix=" (assoc-ref %outputs "out"))
                           (string-append "--sbin-path=" (assoc-ref %outputs "out") "/bin")
                           (string-append "--conf-path=" (assoc-ref %outputs "out") "/share/ngnx-conf")
                           ;; (string-append "--error-log-path=" (assoc-ref %outputs "out") "/var/log/nginx")
                           ;; (string-append "--http-log-path=" (assoc-ref %outputs "out") "/var/log/nginx")
                           ;; (string-append "--pid-path=" (assoc-ref %outputs "out") "/share/nginx/pid")
                           ;;(string-append "--lock-path=" (assoc-ref %outputs "out") "/share/nginx/pid")
                           )))
       ;; (add-after 'install 'fix-root-dirs
       ;;            (lambda* (#:key outputs #:allow-other-keys)
       ;;              ;; 'make install' puts things in strange places, so we need to
       ;;              ;; clean it up ourselves.
       ;;              (let* ((out (assoc-ref outputs "out"))
       ;;                     (share (string-append out "/share/nginx"))
       ;;                     (log (string-append out "/var/log"))
       ;;                     (bin (string-append out "/bin")))
       ;;                ;; This directory is empty, so get rid of it.
       ;;                ;; (rmdir (string-append out "/logs"))
       ;;                ;; Example configuration and HTML files belong in
       ;;                ;; /share.
       ;;                (rename-file (string-append out "/nginx/sbin/nginx")
       ;;                             (string-append bin "/nginx"))
       ;;                (rename-file (string-append out "/nginx/conf")
       ;;                             (string-append share "/conf"))
       ;;                (rename-file (string-append out "/nginx/logs")
       ;;                             (string-append log "/nginx"))
       ;;                (rename-file (string-append out "/nginx/html")
       ;;                             (string-append share "/html")))))
       )))


  (home-page "http://openresty.org")
  (synopsis
   "A fast web application server built on Nginx")
  (description #f)
  (license license:bsd-2))
