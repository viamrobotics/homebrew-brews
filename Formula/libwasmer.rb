class Libwasmer < Formula
  desc "🚀 The Universal WebAssembly Runtime"
  homepage "https://wasmer.io"
  url "https://github.com/wasmerio/wasmer/archive/2.1.0.tar.gz"
  sha256 "10f976eea614a7a958947a695d7f5f05040014688d8dcdc12261af98a4f3452e"
  license "MIT"
  head "https://github.com/wasmerio/wasmer.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "wabt" => :build
  depends_on "wasmer" => :build

  def install
    system "make", "build-capi"
    lib.install "target/release/libwasmer.so"
    include.install "lib/c-api/wasmer.h"
    include.install "lib/c-api/wasmer_wasm.h"
    include.install "lib/c-api/tests/wasm-c-api/include/wasm.h"

    ENV["WASMER_DIR"] = "#{prefix}"
    mkdir_p "#{prefix}/lib/pkgconfig"
    system "bash", "-c", "wasmer config --pkg-config > #{prefix}/lib/pkgconfig/wasmer.pc"
  end

end