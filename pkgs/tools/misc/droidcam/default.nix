{pkgs ? import <nixpkgs> {}}:
with pkgs;
let libjpegStatic = libjpeg.override{enableStatic=true;};
in
stdenv.mkDerivation {
    name="droidcam";
    src = fetchFromGitHub{
        owner = "aramg";
        repo = "droidcam";
        rev = "v1.6";
        sha256= "1d9qpnmqa3pfwsrpjnxdz76ipk4w37bbxyrazchh4vslnfc886fx";
    };
    nativeBuildInputs=[pkgconfig];
    buildInputs=[libjpegStatic ffmpeg alsaLib speex gtk3 libusbmuxd libappindicator xorg.libpthreadstubs xorg.libXdmcp ];
    patches = [./usbmoxd-patch];
    JPEG_DIR=libjpegStatic.out;
    JPEG_LIB="${libjpegStatic.out}/lib";
    sourceRoot = "source/linux";
    installPhase = ''
mkdir -p $out/bin
cp droidcam droidcam-cli $out/bin
    '';
}
