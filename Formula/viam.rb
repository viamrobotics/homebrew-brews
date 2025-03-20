class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.67.1.tar.gz"
  sha256 "298dac8ba502627665cb715a56bf4f24f922ed84f021b1d362c48deeca318343"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 26
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "99409a788888933fd0c73c711bbc4cc18885beb9287800f7a419861913753134"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aa090e0b76e654439fbf733a67b5892647eeea61d0fecbe268a6da7f41fe1166"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a1f058426395e06cf4603c6b9c9e7cb7a3b3e684cd19ae568348008e8960dcb"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
