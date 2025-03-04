{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    aria2
    yt-dlp
  ];

  shellHook = ''
    echo "Starting aria2c in the background..."
    aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all=true --daemon=true --log=aria2.log &
    ARIA2_PID=$!
    echo "aria2c started with PID $ARIA2_PID"
    echo "Run 'yt-dlp --downloader aria2c <URL>' to download."
    echo "Use 'kill $ARIA2_PID' to stop aria2c when done."
  '';
}
