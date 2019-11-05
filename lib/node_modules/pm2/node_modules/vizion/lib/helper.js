function trimNewLine(input) {
  return typeof(input) === 'string' ? input.replace(/\n/g, '') : input;
}

module.exports = {
  trimNewLine: trimNewLine
};