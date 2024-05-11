from setuptools import setup, find_packages

setup(
    name='shovel',
    version='0.1',
    description='A script to manage a NixOS configuration structured in Shovel-style',
    author='yallowraven',
    author_email='yallowrvn@gmail.com',
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'shovel = shovel.shovel:main',
        ],
    },
)