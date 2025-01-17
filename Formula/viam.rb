class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.58.0.tar.gz"
  sha256 "23f1813e238f562a87e25f82f95142bdfd6382591d6297666f82794d90a71c97"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e9e70fdbf0330da51573456d5e75e4ead9b834980fe201bf07183ca8eb25178"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1af32a492f8a8b61f7907362a2db4a621209aab708d5c19774a688cebc2f46cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "982c0f43179e3f6f84456fae63a378d9742099d573b511ab9729d687c161f39a"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
