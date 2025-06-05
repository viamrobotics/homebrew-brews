class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.78.2.tar.gz"
  sha256 "6364cb91e21e281b4c81f59230515890e307d07e139dd4dc41ae86043bc9596c"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f278b329965e039ee8b73bebcf2b8c559721e402a734f527bdf8ec3a31075835"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "208d313150e175271770ab486677f9d29396426dc2ffb86d1d90784da6e27733"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b2f84f398d049133f55670d418dafc3a725fdd2da3083896ec55df7e705ebb0"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
