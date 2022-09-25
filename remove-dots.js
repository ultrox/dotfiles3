const fs = require('fs');
const path = require('path');

const fileList = [
".bashrc",
".gitconfig",
".gitignore",
".profile",
".zimrc",
".zsh_profile",
".zshrc"
];

const target = path.join("/home/marko", ".gitconfig")
fileList.map(f => {
	let p = path.join("/home/marko", f)
try {
fs.unlinkSync(p)
  //file removed
} catch(err) {
	//throw new Error(err)
  console.error(err)
}
})

