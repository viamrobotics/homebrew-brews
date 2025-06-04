class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.78.1.tar.gz"
  sha256 "4934100950e06fdf6b660ab8b6f2543e7e73a02e0be3bfed5ff8302a11b54c12"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "61477a38f15e08027a6876d4d526fd007369fbeb2cc094833e11f84a144538f7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b9f01758d823cb1a95deca522448488800bf87cc4644d5d7ff8e60f2dc7f8691"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7112ffc5642669d3853b148eaac5b16f2a86c530903679710b5489ee9a134dc2"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
