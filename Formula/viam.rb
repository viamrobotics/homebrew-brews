class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.55.0.tar.gz"
  sha256 "6f0c3a636c26c1714a5e7849f63fbf3f13ece49c5945675cc81a77a88c1c1717"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "69acd7e99ae05d06fb9a97556d1bcdc5badd571c53e22ec2b8c6e36f4c14abb0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "170647edd044f8b107fae5af73956d61234643f21db104bba41770704c358f51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd4721d50384afe23c2819b76aa52d3ea20dc3928f541c450e6a29e2d944ee88"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
