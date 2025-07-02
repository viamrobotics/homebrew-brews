class ViamDialdbg < Formula
  desc "Viam dial debugger"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rust-utils.git",
    tag:      "v0.4.0",
    revision: "8ad5ef9a0c2665a68d593d205ad672db931660ff"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rust-utils.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "make", "build-dialdbg"
    bin.install "target/release/viam-dialdbg"
  end

  def caveats
    <<~EOS
      viam-dialdbg may have installed Rust as a dependency via brew. If you
      manage your own Rust installations (via rustup, etc.), you can run `brew
      remove rust` or `brew unlink rust` after installing.
    EOS
  end
end
