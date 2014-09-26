function () {
        return expect(fs.readdirSync('./code')).to.contain('ben.js');
      }