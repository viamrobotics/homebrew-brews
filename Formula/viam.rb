class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.82.1.tar.gz"
  sha256 "2bd63c37d5ddaf42c5d378924f3b6e7d9da040039eabbde75a5595bad7ec162f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5afae8684142541dfbf121a93f4a6979af2bd6d6ce5a2c54e366113e3e69efa3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b87775facf9e66ffbe803685c9c6f664324e91786170cca04ef2c1e6fc36bd1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c36e858b68545e9cdaba5d497cf1d6fe84ff76e436231b77f63bcd3a3908205"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
