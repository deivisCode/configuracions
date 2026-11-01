git clone https://github.com/apognu/tuigreet && cd tuigreet
cargo build --release
mv target/release/tuigreet /usr/local/bin/tuigreet
# mkdir /var/cache/tuigreet
# # chown greeter:greeter /var/cache/tuigreet
# # chmod 0755 /var/cache/tuigreet
