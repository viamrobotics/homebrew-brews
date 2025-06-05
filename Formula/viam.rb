class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.78.2.tar.gz"
  sha256 "6364cb91e21e281b4c81f59230515890e307d07e139dd4dc41ae86043bc9596c"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4469435430769966eea919bba4e46f4db525858dd0d5083dff127aa7d2477799"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "98e4cd881c018a8fa2fc0e1d8005cc32b0cd5040c1b2fb4ba22b787890649da4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3401ff14a1cf39667eb5c470443807bfe0790567e8397d5cd97f402fd9ddd06"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
