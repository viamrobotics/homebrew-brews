class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.86.0.tar.gz"
  sha256 "608a0426df056e4cd11a4de4e628348c06d5dd0eadd3eea5031d12515be87dfc"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c6ea5ced4a73b7b0779f35dceadf99690c0a57f3e8210a1d6b3cc178f141b12d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "75286729f29ad8977e4d2b17988f5dcfad163a6157d2e2d068b61899fca019e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf9c761fd3194c61c7fe15f3a894e7881556794fd3243744cb191305cf5131b5"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
