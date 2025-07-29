class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.86.1.tar.gz"
  sha256 "07d0077b1794001289bb1e1af386a05a1d6cc758eaa8d6d50c534b20fd90e52a"
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
