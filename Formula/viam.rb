class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.91.0.tar.gz"
  sha256 "75d8eea77ca8375517c9594724ce4cdb1752bf1b081bb8b79ee9b100f6f6f51d"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 26
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cb3f8c24867e74930894d7b49b21f89655d30fdd4abcc99018e5d9599d45078c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3ea4136e7d53f0174855e28dbc5a877e3a8463e53ce842aa9cf9e9cc5bad4ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75e2a8d1e1aad687eed52aa55ea2867ef47fa2685ce72a108d255472bf79c196"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
