from setuptools import setup, find_packages

setup(
    name='purr',
    version='0.1',
    description='A simple password manager backed by a human-readable YAML store',
    author='yallowraven',
    author_email='yallowrvn@gmail.com',
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'purr = purr.purr:main',
        ],
    },
)