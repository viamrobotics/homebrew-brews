class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.80.0.tar.gz"
  sha256 "7634b178c167c40cd05c909c068e7425f950c528e6e2dd35ea601028ea73fb88"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8db04f20997a589e710455904307c27aa3a36a60f9761c139a4fdc1f8092d9ae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8871da74ad1644e976403c3009d8462d045252a8369d4ac129e0ac4094da0b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8eea2e33187ad3e31d70f25e502bbc27f1bfc377dec225ade5c5f5d98d31c482"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
