WebpackErrorNotificationPlugin = require('webpack-error-notification')
webpack = require('webpack')

function makeConfig() {
	return {
		entry: {
			shapely: ['./src/shapely']
		},
		target: 'node',
		output: {
			path: './lib',
			filename: '[name].js',
			publicPath: '/lib/',
			libraryTarget: 'commonjs2'
		},
		externals: [
			// all none-relative paths are external
			/^[a-z\-0-9]+/
		],

		resolve: {
			extensions: ['.js', '.json']
		},

		devtool: 'source-map',
		module: {
			loaders: [
					{test: /\.json$/, loader: 'json'},
					{
						test: /\.js$/,
						loader: 'babel',
						exclude: /(node_modules)/,
						query: {
							plugins: ['syntax-flow', 'transform-flow-strip-types'],
							presets: ['es2015', 'stage-1']
						}
					}

				]
			},
		plugins: [
			(new webpack.NoErrorsPlugin()),
			(new WebpackErrorNotificationPlugin())
			]
		}
}

module.exports = makeConfig()