import React from "react"
import PropTypes from "prop-types"

class Product extends React.Component {
  constructor(props) {
    super(props)
    this.changeValue1 = this.changeValue1.bind(this)
    this.state = {
      value1: 0
    }
  }

  changeValue1(newValue) {
    this.setState({
      value1: newValue
    })
  }

  render () {
    const newValue1 = this.state.value1
    const result = this.props.price * parseInt(newValue1) * 52
    const onClickCal = () => {
      if(!isNaN(result)){
        this.setState({answer: result});
      }else{
        this.setState({answer: "数字以外の文字が入力されています"});
      };
    };

    return (
      <>
        {this.props.price}
        <p>×</p>
        <NumericalValue  value={newValue1} valueChange={this.changeValue1} />
        <button onClick={onClickCal}>
          計算する
        </button>
        <p>{this.state.answer}</p>
      </>
    );
  };
}

class  NumericalValue extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(e) {
    this.props.valueChange(e.target.value)
  }

  render () {
    const newValue = this.props.value
    return <input type="text" value={newValue} onChange={this.handleChange} />
  }
}

Product.propTypes = {
  price: PropTypes.integer
}

export default Product
