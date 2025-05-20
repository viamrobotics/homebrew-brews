class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.76.0.tar.gz"
  sha256 "a48f90fa2386b834f2ee4b4156b979d263cf08a9d5a82ab0bb628f0f70fc62c9"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a22076510fb6deaaa4ad172307339280c227800432f4cc578c4060c660807288"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9b61c7a8ebb5e7e12a390d76d5b077be2eb7f20a54418c460c6e0f0ed5538401"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a40f83c031e70844f50014550d2312e809cfe485bd5253ab37f9a6987cecf69"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
