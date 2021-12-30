class LibwasmerAT21 < Formula
  desc "🚀 The Universal WebAssembly Runtime"
  homepage "https://wasmer.io"
  url "https://github.com/wasmerio/wasmer/archive/2.1.1.tar.gz"
  sha256 "f2ca1f3c48983de854b01c87b521e02245654f235d48d339a0e25229e184a322"
  license "MIT"
  head "https://github.com/wasmerio/wasmer.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "wabt" => :build
  depends_on "wasmer" => :build

  def install
    system "make", "build-capi"
    system "make", "package-capi"
    rm "package/include/README.md"
    prefix.install Dir["package/*"]
    ENV["WASMER_DIR"] = "#{prefix}"
    mkdir_p "#{prefix}/lib/pkgconfig"
    system("wasmer config --pkg-config > \"#{prefix}/lib/pkgconfig/wasmer.pc\"")
  end

end
