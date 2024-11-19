class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.51.0.tar.gz"
  sha256 "04cc476e58195eb6dc61a43d6c3a20757fc3f1e5beb1196b8e8d8101c646d76c"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ecf3cc7d670f8241ed3257eaa70147449e42b0c2aeabf88cad3c2af123b4dda6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f881a0a5157631f30819e51c9adf72a0edce43382c8ff0b97bb8430137445b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74cafe808062a71062961d67b982e1c8db45eae97c4a5f3a632b097165ba05d9"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
