class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.67.1.tar.gz"
  sha256 "298dac8ba502627665cb715a56bf4f24f922ed84f021b1d362c48deeca318343"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 27
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6264aaa30d86ef5bb17e5291ac8e0486135adf1a26acfbf4e85c4998d5b7d32b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "00d9c9bad37f6ac87d3ae8fe3a478b4250fac5dfec74bfa5e3c96db26646f203"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d0535af6caabc24af81a40c6171acbb24de06884d1edd07d762157b96635ffb7"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
