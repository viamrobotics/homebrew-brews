class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.50.0.tar.gz"
  sha256 "95bde60d088c40eb6268d51e17795dc67f3d5f08ad6c983fb3ce6106dbdc90da"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6b26b90a6cb35fbfa07abbc8f0e9d58165ddaaeac37d421c31f6140a395aa11d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17e8fc7dd10fb700d3564abe81f179f0ebf03119d84a5bc6fcbc13ceebeb685f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da7199b650cc9a29f90fe1eabaeef187e4594d9118c20a4b28228184ca635721"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
