# O2Physics with Shifter at Perlmutter

## Table of contents

- [Table of contents](#table-of-contents)
- [Contact](#contact)
- [Shifter](#shifter)
- [Using pre-built O2/O2Physics](#using-pre-built-o2o2physics)
- [Building O2Physics from source](#building-o2physics-from-source)
- [Tips and tricks](#tips-and-tricks)
  - [Using aliases in `alienv` environments](#using-aliases-in-alienv-environments)
  - [Generating and using AliEn tokens](#generating-and-using-alien-tokens)
  - [Keeping your O2 software up to date](#keeping-your-o2-software-up-to-date)
  - [`ssh` into a specific login node](#ssh-into-a-specific-login-node)

## Contact

Author: Tucker Hwang  
Date: 26 June 2025  
Contact: [tucker_hwang@berkeley.edu](mailto:tucker_hwang@berkeley.edu) or Slack for issues, questions, or suggestions

## Shifter

To install the Run 3 ALICE software stack on Perlmutter, we will use [Shifter](https://docs.nersc.gov/development/containers/shifter/), a NERSC-specific software that exposes images for use on NERSC systems.  Shifter containers behave somewhat similarly (though with some key differences) to those from Docker. The image we use contains all the dependencies we need to install O2/O2Physics, and can also be used in batch jobs. There are some advantages and disadvantages to using Shifter[^1], so we may migrate to [`podman-hpc`](https://docs.nersc.gov/development/containers/podman-hpc/overview/) (which is closer to Docker) instead.

We currently use this image: `tch285/o2alma:latest`. The image, built from base AlmaLinux 9, has the minimum dependencies that we need for installation (i.e. `aliBuild` and its dependencies), plus some extra convenience packages like `vim`. Unlike a true Docker container, even if the container is run interactively, additional packages cannot be installed (root access is disabled). Note that some scripts in O2/O2Physics may not work due to missing packages (for example, simulations with O2sim sometimes use `time`, which isn't installed by default in base Alma9). You can check the full [Dockerfile](https://github.com/tch285/anchor/blob/main/o2alma/Dockerfile) and the current [list of extra packages](https://github.com/tch285/anchor/blob/main/o2alma/packages) that are available in the container. If you need any extra packages, please let Tucker know!

## Using pre-built O2/O2Physics

If you don't need to develop new code for O2Physics, but you just want to use the software, you can use precompiled binaries from CVMFS. Each day, the current version of the ALICE stack is built and uploaded to CVMFS.

1. If you don't have it already, [obtain a grid certificate](https://alice-doc.github.io/alice-analysis-tutorial/start/cert.html).
2. First, identify which package and version you want to load. If you already know, skip this step. If not, check the [Grid packages](https://alimonitor.cern.ch/packages/) page on AliMonitor for a full list. The page contains a searchable list of all ALICE-related packages, so it can take a long time to fully load. Use the search bar at the top left of the page to filter through the different packages. Take the name of the package in the leftmost column. In this example, we'll use `VO_ALICE@O2Physics::daily-20250514-0328-1`. You can use this name directly, or shorten it to `<package-name>/<tag>` format, i.e. `O2Physics/daily-20250514-0328-1`
3. After logging into Perlmutter, enter the Shifter container with `shifter --image=tch285/o2alma:latest --module=cvmfs /bin/bash --rcfile <path/to/file>`:
    - `--module=cvmfs` mounts the CMVFS binaries (contained in `/cvmfs`) into the container; by default, they are not persisted.
    - `/bin/bash`: start an interactive Bash session. You can replace this with any other command if you want to run that command within the container.
    - `--rcfile <path/to/file>`: the Bash session will not source any of your login scripts. Replace `<path/to/file>` with the local path to any setup scripts, or remove this option completely if not necessary.
4. You can now enter the environment by running `/cvmfs/alice.cern.ch/bin/alienv enter VO_ALICE@O2Physics::daily-20250514-0328-1`.

## Building O2Physics from source

1. If you aren’t aiming to develop for O2Physics and only intending to run the software, explore whether you can use the precompiled binaries on CVMFS, and check the [previous section](#using-pre-built-o2o2physics) if you do.
2. First [obtain a grid certificate](https://alice-doc.github.io/alice-analysis-tutorial/start/cert.html) if you haven't done so already.
3. `ssh` into Perlmutter with your credentials and make sure you have [converted your certificate](https://alice-doc.github.io/alice-analysis-tutorial/start/cert.html#convert-your-certificate-for-using-the-grid-tools).
4. Make and/or enter your work directory. For the rest of this installation, we’ll assume it’s in `~/alice`. Do not try to install in Global Common (`/global/common/software/alice`) - O2 is too large. I recommend installing in a personal directory on CFS (e.g. `/global/cfs/cdirs/alice/$USER`)
5. To run this installation, we’ll be using `tmux` or `screen`. Since Perlmutter has a load balancer that’ll put you (probably) on a random node whenever you log in, it’s important to know where your tmux/screen sessions are running (they don’t persist across login nodes). Find your login node with `echo $HOST` or `hostname`. The output will be the name of the login node you’re in, something like `loginXX` with XX being a two-digit number between 01 and 40.
6. Start a multiplexer window, either with `tmux` or `screen`. I personally recommend `tmux`, since it preserves the full history of the shell (there’s probably some option in `screen` that allows this too but I forget).
7. Enter the Shifter container via

    ```bash
    shifter --image=tch285/o2alma:latest /bin/bash
    ```

    You can add the additional option to load an rc file in your bash session by tacking on `--rcfile <path/to/file>` at the end of the above command.
8. Set up `alienv` with

    ```bash
    export ALIBUILD_WORK_DIR="<path/to/work/dir>/sw"
    eval "$(alienv shell-helper)"
    ```

    Replace `<path/to/work/dir>` with whatever you used in step 1. In that example, we would set `ALIBUILD_WORK_DIR` with: `export ALIBUILD_WORK_DIR="~/alice/sw"`
9. Get O2 with: `aliBuild init O2@dev`
    - We do this because aliBuild will build the dependencies of anything you tell it to build. This means that every time the O2 dependency of O2Physics updates, aliBuild will fully rebuild the new version of O2 from scratch. If we pull O2 into our local build, O2Physics will instead built off of that local version. As long as you keep your local O2 up to date, aliBuild can then intelligently build only what it needs to, instead of a full rebuild.
10. Clone the O2Physics repository. Here are some common options to do this:
    - `aliBuild init O2Physics@master`, which will clone the repo from the main source. If you’re developing for O2Physics, there is essentially no reason for you to do this, since you need a fork to submit PRs. Instead, you should clone your own fork instead:
    - `git clone <your_fork>`: Make a fork of the main O2Physics repository and clone that instead. You can specify a specific branch with `b <your_branch>` and only clone that branch with `--single-branch`. In this case, make sure to swap into the branch you want before you build!
    - In either case you may run into some SSL certification error; in this case run `git config --global http.sslVerify false` and try again. To be clear, **this is in general a terrible, terrible idea**, but unfortunately there is no way to get around this at NERSC without large changes to the NERSC Shifter configuration[^3]. **Once the build is complete, you should set `sslVerify` to `true` again.**
11. Your work directory should now contain directories `O2`, `O2Physics`, `alidist`, and `sw`. Build with `time aliBuild build O2Physics -d -j8`. Here are the explanations for the arguments:
    - `time` is totally optional: I just like to know how long the compilation takes. In my experience it takes around 4-6 hours with these arguments.
    - The `-d` flag results in debug/verbose output, so you can ignore this if you want.
    - `-j8` instructs the node to use fewer cores. aliBuild by default uses the maximum number of available cores, which on Perlmutter login nodes is 256. However, it’s actually better for us to use fewer cores, because the build step can run into problems if there’s not enough available memory per core (which it almost certainly will) - so we reduce the number of cores and thereby increase the available memory per core. If you give it too many cores, you will see an error like

        ```bash
        c++: fatal error: Killed signal terminated program cc1plus
        compilation terminated.
        ```

        From my testing it seems that around 8 cores is the maximum.
12. You can now detach at any point (with `<Ctrl-a> d` on screen or `<Ctrl-b> d` on tmux), and close the ssh connection as you need. If you want to check the progress, log back into Perlmutter, ssh into the login node you found in step 3[^2] (with e.g. `ssh login25`) and reattach to your multiplexer window with `tmux a` or `screen -r`.
13. When the compilation finishes, you’ll get a message like this:

    ```text
    ==> Build of O2Physics successfully completed on `login<XX>'.
        Your software installation is at:
    
          <path/to/work>/sw/slc9_x86-64
    
        You can use this package by loading the environment:
    
          alienv enter O2Physics/latest-<branch-name>-o2
    
    ==> Build directory for devel package O2Physics:
        <path/to/work>/sw/BUILD/O2Physics-latest/O2Physics
    2024-10-31@13:52:13:DEBUG:O2Physics:O2Physics:0: Everything done
    ```

    Make sure to note the `alienv` line, since you’ll need this to enter the environment for the build you just compiled. Also note that your branch name is contained in the `alienv` command you’ll need - this means that you can compile multiple versions of O2Physics, one per branch, and swap to each at will. If you included `time` in your aliBuild command, then you’ll see this at the very end as well:

    ```text
    real    233m19.986s
    user    710m53.578s
    sys     173m19.347s
    ```

    In terms of wall-clock compilation time, you can look at the `real` section.

## Tips and tricks

### Using aliases in `alienv` environments

By default, to avoid conflicts, the shell produced by `alienv enter` loads no shell scripts. This means no aliases or other helpful things are maintained. There are two ways to avoid this:

1. You can force `alienv` to load your login scripts anyway by attaching `--shellrc` to your `alienv` command, e.g. `alienv enter --shellrc O2Physics/latest-master-o2`
2. If you want it to load a specific script (useful if you have multiple builds or installation and/or you want some specific commands for your O2 work but not pollute your user environment) you can run

    ```bash
    alienv setenv O2Physics/latest-master-o2 -c /bin/bash -i --rcfile <path/to/file>
    ```

    `alienv setenv` is useful to run a single command inside the environment. In this case, we make it open an interactive bash session (`-i`) with a specific startup script. You can even make it load your login scripts with `/bin/bash -l`.

### Generating and using AliEn tokens

If you need to only generate the token, you can enter any O2 environment (either built by you or via CVMFS) and run `alien-token-init`, verify it with `alien-token-info`, or destroy an existing token with `alien-token-destroy`. The token certificate and key exists in `/tmp` as `/tmp/tokencert_$UID.pem` and `/tmp/tokenkey_$UID.pem`, respectively, where `$UID` is your user ID (which you can check by running `echo $UID`).

Keep in mind that your tokens will only exist on the login node you generated them on. They won't exist on other login nodes or on the compute nodes unless you generate them there.  This makes it difficult to use in e.g. batch jobs, since there is no way to provide your password.  There are some ways to alleviate this problem: if you need the tokens accessible...

1. **... in a batch job, or on other login nodes**: Credit to Florian for this method: once you generate the keys on one node, you copy them somewhere into your home directory, e.g. `cp /tmp/token*_$UID.pem $HOME/tokens`. When you are on another login node, a compute node, or in a batch job, you can then direct the software to use these keys with

    ```bash
    export JALIEN_TOKEN_CERT=$HOME/tokens/tokencert_$UID.pem
    export JALIEN_TOKEN_KEY=$HOME/tokens/tokenkey_$UID.pem
    export ALIENPY_DEBUG_FILE=/tmp/$UID_alien_py.log
    ```

    This is currently the only option for batch jobs. It's a less ideal solution for login nodes, since you'd have to set these variables every time you enter the node. For that, see the next solution.
2. **... on other login nodes**: You can simply generate them on one node and use `scp` to copy them to all of the other login nodes. An example script is below. Keep in mind that since any login nodes that are inaccessible at the time of running the script will not have these keys copied, so you may have to run it again later.
    <details>

    <summary>Simple copy script</summary>

    ```bash
    #!/usr/bin/bash

    PARSEDARGS=$(getopt -o f \
                        --long force \
                        -n 'refresh-token' -- "$@")
    PARSE_EXIT=$?
    if [ $PARSE_EXIT -ne 0 ] ; then exit $PARSE_EXIT ; fi

    eval set -- "$PARSEDARGS"

    force=
    while true; do
      case "$1" in
        -f | --force ) force="true"; shift ;;
        -- ) shift; break ;;
        * ) break ;;
      esac
    done

    if command -v shifter >/dev/null 2>&1; then
      info () {
        shifter --module=cvmfs --image=tch285/o2alma:latest /cvmfs/alice.cern.ch/bin/alienv setenv JAliEn-ROOT/0.7.14-43 -c alien-token-info
      }
      init () {
        shifter --module=cvmfs --image=tch285/o2alma:latest /cvmfs/alice.cern.ch/bin/alienv setenv JAliEn-ROOT/0.7.14-43 -c alien-token-init
      }
    else
      info () {
        /cvmfs/alice.cern.ch/bin/alienv setenv JAliEn-ROOT/0.7.14-43 -c alien-token-info
      }
      init () {
        /cvmfs/alice.cern.ch/bin/alienv setenv JAliEn-ROOT/0.7.14-43 -c alien-token-init
      }
    fi

    info > /dev/null 2>&1
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "AliEn token found."
      if [ -n "$force" ]; then echo "Force refreshing token:" && init; fi
    elif [ $exit_code -eq 2 ]; then
      echo "Token expired/not found, refreshing:" && init
    else
      echo "Exit code $exit_code unrecognized, crashing out." && exit $exit_code
    fi

    start=1
    end=40
    total=$((end - start + 1))
    nhashes=20

    startbar='[>'
    for ((j=0; j<nhashes-1; j++)); do startbar+=" "; done
    startbar+=']'
    echo -ne "Progress: $startbar ($percent%) [0/$total]\r"

    count=0
    failed=()
    trap "echo -e \"\nCopy canceled.\"; exit" SIGINT
    for i in $(seq -f "%02g" "$start" "${1:-$end}"); do
      # Remove if exists (scp can't overwrite on its own)
      ssh "login$i" "ls /tmp/token*_\$UID.pem &> /dev/null && rm -rf /tmp/token*_\$UID.pem"
      scp /tmp/token*_$UID.pem "login$i:/tmp" &> /dev/null
      ecode=$?
      if [ $ecode -ne 0 ]; then failed+=("$i"); fi

      count=$((count + 1))
      percent=$((count * 100 / total))

      # Calculate how many hash marks to show
      hashes=$((count * nhashes / total))
      spaces=$((nhashes - hashes))

      # Build the progress bar
      progress="["
      for ((j=0; j<hashes; j++)); do
        progress+="#"
      done
      for ((j=0; j<spaces; j++)); do
        progress+=" "
      done
      progress+="]"

      echo -ne "Progress: $progress ($percent%) [$count/$total]\r"
    done

    if [ ${#failed[@]} -ne 0 ]; then
      echo -ne "\nDone: scp failed for the following node(s): "
      for node in "${failed[@]}"; do echo -n "$node "; done
      echo
    else echo -e "\nDone."; fi
    ```

    </details>

### Keeping your O2 software up to date

- **To keep O2Physics up to date**, a rebase on the upstream and rebuild with e.g. `aliBuild build O2Physics -j8` should do. In principle, this isn't so necessary to do all the time, especially since O2Physics is updated constantly from everyone's analyses, most of which aren't relevant to yours. In general, you should rebase/rebuild only if (1) someone has made changes that's relevant to you; or (2) you're submitting a PR. In this case you want to make sure your code will work with everything at the latest version, so make sure to update O2 and alidist as well.
- **To keep O2 up to date**, go to your O2 directory at `<path/to/work>/O2` and run `git pull`. Development in O2Physics runs in parallel in O2 - for example, much of the basic table structure is implemented in O2. This means that your O2Physics build may fail due to an out-of-date O2. This happens somewhat frequently, and may cause build failures when it tries to build someone else's code if you incorporate these changes in your O2Physics.
  - There is no need to build O2 separately with its own aliBuild command - when you (re)build O2Physics, aliBuild will know that O2 is a dependency and build O2 as well. This is why it's important to clone a local version of O2 to allow aliBuild to intelligently build only the parts of O2 that have been changed since the last rebuild. If you don't, whenever the O2 version changes in alidist, it will rebuild O2 from scratch, even if the changes themselves were minor.
- **To keep the other dependencies** installed by aliBuild up to date, go to `<path/to/work>/alidist` and run `git pull`. Like O2, these dependencies will also be rebuilt (if necessary) when you (re)build O2Physics.

### `ssh` into a specific login node

Credit to Nicholas Tyler on the NERSC team for this tip!

A direct `ssh` from your local system is not allowed, but one can use jump hosts to connect to Perlmutter first and then connect to a login node. A setup like this in your `~/.ssh/config` should work:

```text
Host dtn*
    HostName %h.nersc.gov

Host login??
    HostName %h.chn.perlmutter.nersc.gov
    StrictHostKeyChecking no
    ProxyJump dtn

Host dtn* login??
    User <your-username>
    IdentityFile ~/.ssh/nersc
    IdentitiesOnly yes
    ForwardAgent yes
```

Make sure to replace `<your-username>` with your Perlmutter username. By default the `sshproxy` tool generates your temporary SSH key in `~/.ssh/nersc`. If it is somewhere else, modify the `IdentityFile` line to the relevant path.

With this setup, you should now be able to just run `ssh login<XX>` which will take you directly to the login node you specified.

[^1]: One major advantage is that, in contrast with Podman, volumes do not have to be explicitly mounted.
[^2]: It is possible to ssh directly into a specific login node, but the setup is a little involved. It's definitely a little overkill for this kind of thing so just do it manually and you can check the [relevant section](#generating-and-using-alien-tokens) later.
[^3]: It’s not enough to clone outside the Shifter container either, since aliBuild will clone all of the repository dependencies through https.
