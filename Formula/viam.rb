class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.43.0.tar.gz"
  sha256 "efbe2508d7642aca7f6d3a3be2d24184e83a3fb98ba159462d4a415734a14cb9"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "29b11a40e465ea128aed49485c89d606465f084a16a11d373f82f594ff561a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "81b37348349dc500ce59cae47411fd7b0087385e3be51da0f360c8fea05b729c"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
