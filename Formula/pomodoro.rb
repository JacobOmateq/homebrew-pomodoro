class Pomodoro < Formula
  desc "Terminal-based Pomodoro timer with statistics and CalDAV sync"
  homepage "https://github.com/JacobOmateq/pomodoro"
  url "https://github.com/JacobOmateq/pomodoro/archive/refs/heads/main.zip"
  version "1.0.0"
  sha256 "" # This will be calculated when you create a release
  
  depends_on "python@3.11"

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    
    # Install dependencies from requirements.txt
    requirements = buildpath/"requirements.txt"
    system python3, "-m", "pip", "install", "--prefix=#{libexec}", "-r", requirements
    
    # Install the script
    bin.install "pomodoro.py" => "pomodoro"
    chmod 0755, bin/"pomodoro"
    
    # Create a wrapper script that uses the installed Python packages
    (bin/"pomodoro").write_env_script bin/"pomodoro", 
      PYTHONPATH: "#{libexec}/lib/python3.11/site-packages:$PYTHONPATH"
  end

  test do
    system "#{bin}/pomodoro", "--help"
  end
end
