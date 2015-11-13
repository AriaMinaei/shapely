WebpackErrorNotificationPlugin = require('webpack-error-notification')
webpack = require('webpack')

function makeConfig() {
	return {
		entry: {
			shapely: ['./src/shapely']
		},
		output: {
			path: './lib',
			filename: '[name].js',
			publicPath: '/lib/',
			libraryTarget: 'commonjs'
		},
		externals: [
			// all none-relative paths are external
			/^[a-z\-0-9]+$/
		],

		resolve: {
			extensions: ['.js', '.json']
		},

		module: {
			loaders: [
					{test: /\.json$/, loader: 'json'},
					{
						test: /\.js$/,
						loader: 'babel',
						exclude: /(node_modules)/,
						query: {
							presets: ['es2015']
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