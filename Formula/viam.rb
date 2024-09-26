class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.43.0.tar.gz"
  sha256 "efbe2508d7642aca7f6d3a3be2d24184e83a3fb98ba159462d4a415734a14cb9"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c4ae26d27e85aa9407afcb35e167695de23d718faba99e6687e5e920412012a7"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
