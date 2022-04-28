import React from "react"
import Modal from 'react-modal';
import PropTypes from 'prop-types'

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    height                : 'auto',
    width                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)',
    overFlow             : 'scroll'
  }
};

class SelectModal extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  render() {
    return (
      <>
        <button onClick={this.openModal}>商品を選択</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Modal">
          <h2>Hello</h2>
          <ProductList products={this.props.products} />
          <button onClick={this.closeModal}>閉じる</button>
        </Modal>
      </>
    );
  }
}

const ProductList = (props) => {
  return(
    <>
      {props.products.map((product) =>
      <ProductItem product={product} key={product.id} /> )}
    </>
  )
}

ProductList.propTypes = {
    products: PropTypes.array.isRequired
}

const ProductItem = (props) => {
    const {name} = props.product
    return (
        <div>{name}</div>
    )
  }

  ProductItem.propTypes = {
    product: PropTypes.object.isRequired
  }

export default SelectModal
