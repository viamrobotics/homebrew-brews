class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.56.0.tar.gz"
  sha256 "9bc0ed9875111a40f3506ed61ed21f5783ffc7b2a965092670173443fe640bb1"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c1522c6ab0026ba6707fdcfaf1c45c2bb52b127157f166f371930c5adddd9ffe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "df2d8e71cb89db278fb7c255a7af800d883150087d128251c4862131ca047e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2b2b204e06be0f7dc5906b7dcb329f9cd8f1c0867fd5904b0d186f4d1ae4a70"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
