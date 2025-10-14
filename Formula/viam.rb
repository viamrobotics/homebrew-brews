class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.97.0.tar.gz"
  sha256 "9162bb92775c76c747e811cc289c8ef846d1af0f463aa39b15a10f87e1d457c7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 33
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5bc6840e3af3ae11547628fc7906d74059c07b89cfe1409918aac84bc8037e19"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9ee7a60b2299aa3379d0a875af64d8a2bdddf9734aed4c7b0a5bf4e069fde71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a93d8eb37d0bdc1583c2404c779aa20f52aa980e95dcb8b32ff109381d5f607"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
