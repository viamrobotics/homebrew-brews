class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.66.0.tar.gz"
  sha256 "3a72a57f2c51e54673cd2109671d28f5117e11a691d1780b8f8261c3d633e4cb"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 25
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2bdb447d98b50cbe0837b0e523a0f1ee1992bb49676739d384d39b7e990ea306"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "101525807a7bb91f600494ce6b6ae5b6b5d5e1293b0912bbfe4d76f50488328e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82dfbc40e7625faa63659b1fcb89b0e4edb090e448da12c9c0a9ba763ec0af94"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
