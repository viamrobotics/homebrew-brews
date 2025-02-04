class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.61.0.tar.gz"
  sha256 "175dd8d4ff326757bc58bd87b117b3f7ddcaef0b222bf7853fb859dcac6ad897"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 19
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c2bf1adac55e7065fdb06bbf8c51a5f0be9d594a2a891efd872ad436a4c7f9bb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d7e8f61e0aa66b84629d1c83a61bd16e0d46acf35f864655a749c7135d1e5806"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07a19725d4adff3228ba4763107d61ef69a175686c172a8067e607a755634da4"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
