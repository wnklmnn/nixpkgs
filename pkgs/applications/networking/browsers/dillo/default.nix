{ stdenv, fetchurl
, fltk
, openssl
, libjpeg, libpng
, perl
, libXcursor, libXi, libXinerama, which, autoreconfHook }:

stdenv.mkDerivation rec {
  version = "3.0.5";
  pname = "dillo";

  src = fetchurl {
    url = "https://www.dillo.org/download/${pname}-${version}.tar.bz2";
    sha256 = "12ql8n1lypv3k5zqgwjxlw1md90ixz3ag6j1gghfnhjq3inf26yv";
  };
  nativeBuildInputs = with stdenv.lib; [ which autoreconfHook perl ];
  buildInputs = with stdenv.lib; [ fltk openssl libjpeg libpng libXcursor libXi libXinerama ];
  patches = [ ./fix-OpenSSL-1.1-detection.patch];
  configureFlags = [ "--enable-ssl" ];

  meta = with stdenv.lib; {
    homepage = https://www.dillo.org/;
    description = "A fast graphical web browser with a small footprint";
    longDescription = ''
      Dillo is a small, fast web browser, tailored for older machines.
    '';
    maintainers = [ maintainers.AndersonTorres ];
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
