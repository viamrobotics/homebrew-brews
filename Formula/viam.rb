class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.56.0.tar.gz"
  sha256 "9bc0ed9875111a40f3506ed61ed21f5783ffc7b2a965092670173443fe640bb1"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "753cb515552dfebf2330e5646382e7c5e9d2f01d75ff4443860fbe0752ba6046"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8280b98b560d55de4e08eb2199c43f7d388f24f9d8fcb7cf601dbadea7e33324"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0b04cee5fec207d2017c2c8114ea8e4fb0531fff814dfe10d6e2ffb3d9a70fe"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
