class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.86.2.tar.gz"
  sha256 "4d98690aa9e2a87ee17003b81d0ddbfe22af5f86a6792d760e378e743c89a025"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 17
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b7b7c6b2855f3e89eb767be9a451e52d1881d73b41fc15e044a666d2df0e7886"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebf76515d7f9239c13943f88ccd5ef443d411a7a2fd4fad7a7f454a8b8a6a661"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d40ff269d9a4edb661226d8dfb0bb5a742384ba4416354ba9a550abf08549a8b"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
