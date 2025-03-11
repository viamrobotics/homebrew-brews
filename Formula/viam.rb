class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.66.0.tar.gz"
  sha256 "3a72a57f2c51e54673cd2109671d28f5117e11a691d1780b8f8261c3d633e4cb"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 24
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d2a253494f2140cdbd6ebc987bd097dc8d874c838e5ac4769e132d31ebec9edd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8b69931914234376df522664c82ef9772aa13c87420d84bab78ebf26326c7383"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c65de1d49255f4edb35f48bdd3a35182d5e40e3fdc22e38c53d4b73c1efc0a38"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
